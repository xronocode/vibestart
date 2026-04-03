from __future__ import annotations

import os
import shutil
import stat
import subprocess
import tempfile
import unittest
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[1]
WRAPPER = REPO_ROOT / "bootstrap-from-git.sh"


class BootstrapFromGitTests(unittest.TestCase):
    def setUp(self) -> None:
        self.tmpdir = Path(tempfile.mkdtemp(prefix="vibestart-git-test-"))

    def tearDown(self) -> None:
        shutil.rmtree(self.tmpdir)

    def create_source_repo(self) -> Path:
        source = self.tmpdir / "source"
        (source / "docs/vibe").mkdir(parents=True)
        for relative in [
            "vibestart",
            "bootstrap-from-git.sh",
            "vibe.toml",
            "docs/vibe/governance.toml",
            "docs/vibe/macros.toml",
        ]:
            src = REPO_ROOT / relative
            dst = source / relative
            dst.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(src, dst)

        for relative in ["vibestart", "bootstrap-from-git.sh"]:
            path = source / relative
            path.chmod(path.stat().st_mode | stat.S_IXUSR)

        subprocess.run(["git", "init"], cwd=source, check=True, capture_output=True, text=True)
        subprocess.run(["git", "config", "user.name", "VIBE Test"], cwd=source, check=True, capture_output=True, text=True)
        subprocess.run(["git", "config", "user.email", "test@example.com"], cwd=source, check=True, capture_output=True, text=True)
        subprocess.run(["git", "add", "."], cwd=source, check=True, capture_output=True, text=True)
        subprocess.run(["git", "commit", "-m", "test source"], cwd=source, check=True, capture_output=True, text=True)
        subprocess.run(
            ["git", "tag", "-a", "v0.1.0-beta.1-test", "-m", "test prerelease"],
            cwd=source,
            check=True,
            capture_output=True,
            text=True,
        )
        return source

    def test_wrapper_bootstraps_target_repo_from_git_source(self) -> None:
        source = self.create_source_repo()
        target = self.tmpdir / "pilot"
        target.mkdir()

        result = subprocess.run(
            [
                "bash",
                str(WRAPPER),
                "--repo",
                str(source),
                "--ref",
                "v0.1.0-beta.1-test",
                "--core",
                "--target",
                str(target),
            ],
            cwd=target,
            check=True,
            text=True,
            capture_output=True,
            env={**os.environ},
        )

        self.assertIn("Fetching vibestart from git source", result.stdout)
        self.assertTrue((target / "vibe.toml").exists())
        self.assertTrue((target / "docs/vibe/governance.toml").exists())
        self.assertTrue((target / "docs/knowledge-graph.xml").exists())
        self.assertIn("vibestart profile: core", result.stdout)


if __name__ == "__main__":
    unittest.main()
