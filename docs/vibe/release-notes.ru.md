# vibestart v4.0.0-beta.2

`v4` - это не просто новая версия `vibestart`, а мейджорное переосмысление всей линии продукта.

Если `v3.x` был в первую очередь bootstrap/runtime набором и legacy skill corpus, то `v4` перестраивает `vibestart` вокруг новой methodology-first основы: `VIBE` - `Verified Intent-Based Engineering`.

Это новая публичная линия, в которой:
- работа строится от инженерной цели, а не от ручного запуска отдельных фаз
- graph, contracts, verification и governance становятся canonical root surface
- конфигурация и operating policy выражаются явно, а не скрыто в tool-specific mechanics
- bootstrap путь становится target-repo-first: внедрение начинается из целевого репозитория

## Что объединяет v4

`v4` сознательно объединяет и переосмысляет сильные стороны двух уже существующих подходов:

- [osovv/grace-marketplace](https://github.com/osovv/grace-marketplace)
- [aka-NameRec/ai-standards](https://github.com/aka-NameRec/ai-standards)

| Подход | Сильная сторона | Как это переосмыслено в `VIBE / vibestart v4` |
| --- | --- | --- |
| `grace-marketplace` | graph-anchored code engineering, contracts, verification-first execution, controller-managed skills | сохраняется глубина graph/contract/verification discipline, но публичный workflow переносится в VIBE macros и чистую root artifact surface |
| `ai-standards` | manifest-driven AI instruction composition, reusable fragments, project-local overrides | сохраняется explicit config/policy composition, но она привязана к VIBE manifests, governance, macro contracts и bootstrap profiles |
| `VIBE / vibestart v4` | unified line | объединяет graph-first knowledge, contract-first execution, explicit config surfaces и target-repo-first bootstrap в одну clean methodology-first product surface |

## Что меняется по сути

Главный сдвиг в `v4`:
- от skill-centric/tool-centric модели к methodology-first модели
- от разрозненных scripts и legacy flows к clean public root surface
- от ручной orchestration burden к macro-driven workflow
- от неявного operational behavior к deterministic governance и traceable autonomy

Новый публичный workflow строится вокруг макросов:
- `discover`
- `refine`
- `deliver`
- `fix`
- `sync`
- `resume`
- `deploy`
- `vibe`

Это значит, что система идет от intent к closure path, а не требует вручную вызывать локальные шаги по одному.

## Что вошло в beta.1

`v4.0.0-beta.1` зафиксировал новую основу:
- clean public root surface для `VIBE / vibestart`
- quarantined `legacy/` и `internal/` boundaries
- активный `vibestart` bootstrap entrypoint
- explicit `--core` и `--deep`
- deterministic first-run contract
- VIBE-native beta readiness note
- VIBE-native operator guide
- richer generic XML scaffolds для первого реального project loop

## Что добавляет beta.2

`v4.0.0-beta.2` добавляет следующий принципиальный шаг:
- target-repo-first bootstrap path
- `bootstrap-from-git.sh`
- bootstrap из git прямо в текущий target repository
- новый prerelease adoption UX без обязательного long-lived local framework checkout как основного пути

Именно это делает внедрение ближе к реальному использованию в новом проекте:
1. находишься в новом репозитории
2. дергаешь `vibestart` из git
3. инициализируешь VIBE в текущем repo

## Текущее состояние

Сейчас честный статус такой:
- `core` - рекомендуемый beta path для одного проекта
- `deep` - explicit и supported, но richer adapters пока draft-level
- canonical methodology surface уже оформлена
- clean bootstrap path уже работает
- полная operational parity со всем legacy GRACE skill corpus еще не достигнута

## Ограничения текущего prerelease

- не вся детальная GRACE operational mechanics еще переоформлена в новый clean-root VIBE corpus
- `deep` пока не раскрыт так глубоко, как задуман
- richer multi-agent и integration contours остаются следующими этапами
- это beta новой методологии и нового bootstrap path, а не финальный complete runtime product

## Короткая формула

- `v3.x` = legacy vibestart line
- `v4.x` = новая `VIBE / vibestart` methodology-first line
