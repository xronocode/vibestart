from __future__ import annotations

import shutil
import subprocess
import tempfile
import unittest
import xml.etree.ElementTree as ET
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[1]
ENTRYPOINT = REPO_ROOT / "vibestart"


def load_toml(path: Path):
    try:
        import tomllib  # type: ignore[attr-defined]
    except ModuleNotFoundError:  # pragma: no cover
        import tomli as tomllib  # type: ignore[no-redef]
    with path.open("rb") as fh:
        return tomllib.load(fh)


class VibestartBootstrapTests(unittest.TestCase):
    def setUp(self) -> None:
        self.tmpdir = Path(tempfile.mkdtemp(prefix="vibestart-test-"))

    def tearDown(self) -> None:
        shutil.rmtree(self.tmpdir)

    def run_cli(self, *args: str, check: bool = True) -> subprocess.CompletedProcess[str]:
        result = subprocess.run(
            ["python3", str(ENTRYPOINT), *args],
            cwd=REPO_ROOT,
            text=True,
            capture_output=True,
        )
        if check and result.returncode != 0:
            self.fail(result.stderr or result.stdout)
        return result

    def test_core_bootstrap_writes_shared_surface_and_prints_first_run_contract(self) -> None:
        target = self.tmpdir / "core-project"
        target.mkdir()

        result = self.run_cli("--core", "--target", str(target))

        root = load_toml(target / "vibe.toml")
        self.assertEqual(root["bootstrap"]["profile"], "core")
        self.assertEqual(root["execution"]["autonomy"], "guided")
        self.assertEqual(root["execution"]["agents"], "single")
        self.assertFalse(root["capabilities"]["external_integrations"])

        ET.parse(target / "docs/requirements.xml")
        ET.parse(target / "docs/development-plan.xml")
        ET.parse(target / "docs/verification-plan.xml")
        ET.parse(target / "docs/knowledge-graph.xml")
        ET.parse(target / "docs/decisions.xml")
        load_toml(target / "docs/vibe/governance.toml")
        load_toml(target / "docs/vibe/macros.toml")

        self.assertTrue((target / ".vibestart/state/.gitkeep").exists())
        self.assertIn("vibestart profile: core", result.stdout)
        self.assertIn("Installed:", result.stdout)
        self.assertIn("Active defaults:", result.stdout)
        self.assertIn("Optional:", result.stdout)
        self.assertIn("Interaction model:", result.stdout)
        self.assertIn("type v or м to accept the current recommendation bundle", result.stdout)
        self.assertIn("discover -> refine -> deliver/fix -> sync", result.stdout)

    def test_deep_bootstrap_sets_profile_and_preserves_safe_defaults(self) -> None:
        target = self.tmpdir / "deep-project"
        target.mkdir()

        result = self.run_cli("--deep", "--target", str(target))
        root = load_toml(target / "vibe.toml")

        self.assertEqual(root["bootstrap"]["profile"], "deep")
        self.assertEqual(root["execution"]["autonomy"], "guided")
        self.assertEqual(root["execution"]["agents"], "single")
        self.assertIn("deeper deployment and integration scaffolding", result.stdout)

    def test_dry_run_does_not_write_files(self) -> None:
        target = self.tmpdir / "dry-run-project"
        target.mkdir()

        result = self.run_cli("--core", "--target", str(target), "--dry-run")

        self.assertIn("Dry run only. No files were written.", result.stdout)
        self.assertFalse((target / "vibe.toml").exists())
        self.assertFalse((target / "docs").exists())

    def test_missing_explicit_profile_fails_without_tty(self) -> None:
        target = self.tmpdir / "no-profile-project"
        target.mkdir()

        result = self.run_cli("--target", str(target), check=False)

        self.assertNotEqual(result.returncode, 0)
        self.assertIn("Explicit profile selection is required", result.stderr)

    def test_existing_surface_requires_force(self) -> None:
        target = self.tmpdir / "existing-project"
        target.mkdir()
        (target / "vibe.toml").write_text("existing = true\n", encoding="utf-8")

        result = self.run_cli("--core", "--target", str(target), check=False)

        self.assertNotEqual(result.returncode, 0)
        self.assertIn("Refusing to overwrite existing VIBE surfaces without --force", result.stderr)

    def test_generated_scaffolds_define_a_usable_first_project_loop(self) -> None:
        target = self.tmpdir / "loop-project"
        target.mkdir()

        self.run_cli("--core", "--target", str(target))

        requirements = ET.parse(target / "docs/requirements.xml").getroot()
        self.assertIsNotNone(requirements.find("./UseCases/UC-001"))
        self.assertIsNotNone(requirements.find("./UseCases/UC-002"))
        self.assertIsNotNone(requirements.find("./UseCases/UC-003"))
        self.assertEqual(requirements.findtext("./OperatingLoop/step-2"), "Use discover and refine before treating the first slice as implementation-ready.")

        plan = ET.parse(target / "docs/development-plan.xml").getroot()
        initial_module = plan.find("./Modules/M-001")
        self.assertIsNotNone(initial_module)
        self.assertEqual(initial_module.attrib["NAME"], "InitialProjectSlice")
        self.assertEqual(plan.findtext("./ImplementationOrder/Phase-1/step-1"), "Clarify the first stable project slice in the graph and project it into the initial module contract.")

        verification = ET.parse(target / "docs/verification-plan.xml").getroot()
        self.assertIsNotNone(verification.find("./ModuleChecks/V-M-001"))
        self.assertEqual(verification.findtext("./PhaseGates/Phase-Gate-2/name"), "First Slice Ready")

        graph = ET.parse(target / "docs/knowledge-graph.xml").getroot()
        self.assertEqual(graph.findtext("./Nodes/M-001/type"), "CORE_LOGIC")
        self.assertIsNotNone(graph.find("./Edges/edge[@from='W-001'][@to='M-001'][@type='implemented-by']"))
        self.assertIsNotNone(graph.find("./CrossLinks/CrossLink[@from='M-001'][@to='V-M-001'][@doc='verification-plan.xml']"))

        decisions = ET.parse(target / "docs/decisions.xml").getroot()
        self.assertIn("Do not copy framework-repository decisions into this project", decisions.findtext("./BootstrapGuidance/note-2"))


if __name__ == "__main__":
    unittest.main()
