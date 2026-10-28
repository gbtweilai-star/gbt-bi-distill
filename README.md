# bi_distill

**One capability bit from GBT V8, packaged standalone.** No. 64 of 341,
`data` domain (Data).

<p>
<img alt="python" src="https://img.shields.io/badge/python-3.9%2B-blue">
<img alt="license" src="https://img.shields.io/badge/license-MIT-green">
<img alt="deps" src="https://img.shields.io/badge/runtime%20dependencies-0-brightgreen">
</p>

> **蒸馏件**（不是外挂）：把吞入件 dataease/dataease（**GPL-3.0**〔README 徽章明写 GPL v3；GitHub 未识别才标 NOASSERTION〕· 24603星 · Java「人人可用的开源 BI 工具」）蒸成三条取法+一条红线：①拖拽即建模（先把数据做成可拖拽的字段模型，再谈图）②连接面如实列（「支持 X」= 真连得上；OLTP/OLAP/数仓/文件/API 五类照实登记，连不上如实说）③可分享是产品属性（分析产物必须能交出去，不留在自己盘里）④🔴**许可红线 GPL-3.0：只引用不复制**（复用其实现要先过 GPL）。op=source 现读胶囊尺寸+逐文件 sha256 · op=provenance 逐条指回原话（含**未蒸馏**一行：离线安装包/install.sh 不取）。**零作用域**。边界：接入端 ≡ 我们**已有**的 genoffice/datakit/record_grid；本位只蒸取法，**不建平行位**。op=method/source/provenance/where

That description is copied verbatim from the registry. `tests/test_spec.py` pins it,
so documentation drift fails the build instead of shipping quietly.

## What this package actually is

It is the **contract** for one capability: its name, its parameters, the values it
accepts, and whether it can change state that cannot be restored. It is not the
implementation — that lives in the runtime this bit was extracted from.

So `run()` goes through a narrow `Backend` protocol, and the default backend is a
stub that **says so**:

```
status="validated"   backend="stub"   data={"executed": false}
```

Never `status="ok"`. A stub that reports success is worse than no stub, because the
caller stops looking for the real thing.

## Install

```bash
git clone https://github.com/gbtweilai-star/gbt-bi-distill.git
cd gbt-bi-distill
python -m pip install -e ".[dev]"
```

## Use

```bash
python -m gbt_bi_distill info                  # capability card
python -m gbt_bi_distill spec --json           # machine-readable contract
python -m gbt_bi_distill check --payload '{}'
python -m gbt_bi_distill run   --payload '{}'
```

Real `info` output from this machine:

```text
bi_distill  (data)  v1.0.0
----------------------------------------
**蒸馏件**（不是外挂）：把吞入件 dataease/dataease（**GPL-3.0**〔README 徽章明写 GPL v3；GitHub 未识别才标 NOASSERTION〕· 24603星 · Java「人人可用的开源 BI 工具」）蒸成三条取法+一条红线：①拖拽即建模（先把数据做成可拖拽的字段模型，再谈图）②连接面如实列（「支持 X」= 真连得上；OLTP/OLAP/数仓/文件/API 五类照实登记，连不上如实说）③可分享是产品属性（分析产物必须能交出去，不留在自己盘里）④🔴**许可红线 GPL-3.0：只引用不复制**（复用其实现要先过 GPL）。op=source 现读胶囊尺寸+逐文件 sha256 · op=provenance 逐条指回原话（含**未蒸馏**一行：离线安装包/install.sh 不取）。**零作用域**。边界：接入端 ≡ 我们**已有**的 genoffice/datakit/record_grid；本位只蒸取法，**不建平行位**。op=method/source/provenance/where

gated      : False
external   : False
multi-op   : True
params     : (none)
values     : genoffice, datakit, record_grid
```

Wire a real implementation:

```python
from gbt_bi_distill import run

class MyBackend:
    name = "my-backend"
    def invoke(self, cap, payload):
        return {"cap": cap, "handled": sorted(payload)}

result = run({}, backend=MyBackend())
assert result.status == "ok"
```

## Parameters

| name | required | notes |
|---|---|---|
| — | no | the registry declares no required parameters |

Registry hint (`params_hint`): (empty)

**注册表登记的取值 / 子动作（3 个）**：`genoffice`、`datakit`、`record_grid`

Types are deliberately absent: the registry does not declare them, and an invented
type is worse than no type, because callers believe it.

## Boundaries

- Not gated: the registry marks this bit `safe: true`.
- No external service dependency declared.
- Multi-op (`multi_op: true`): several sub-actions share one name — read `op` before calling.
- No implementation ships here. Bring a backend; the protocol is one method.

## What this is not

Not a wrapper around a hosted API. Not a model. Not a promise that calling it does
anything on its own. It is the typed seam plus the validation, which is the part that
stays correct even when the implementation changes.

## Tests

```bash
python -m pytest
```

```text
20 passed, 3 skipped in 0.12s
```

## Provenance

| field | value |
|---|---|
| capability | `bi_distill` |
| domain | `data` |
| handler | `bi_distill` |
| safe | `True` (gated = `False`) |
| external | `False` |
| atlas page | [data/bi_distill](https://github.com/gbtweilai-star/gbt-caps/blob/main/caps/data/bi_distill.md) |
| full index | [https://github.com/gbtweilai-star/gbt-caps](https://github.com/gbtweilai-star/gbt-caps) |

The parent README says 348 capabilities; an AST pass over the registry enumerates
`341 + 0 unimplemented + 0 disabled = 341`. The extra 7 are historical duplicates.
Numbering here follows 341 and matches the `gbt-caps` index one-to-one.

## License

MIT.
