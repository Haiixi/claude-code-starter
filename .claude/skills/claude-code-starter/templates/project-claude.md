# Project: [PROJECT_NAME]

> 填写说明：将 `[PROJECT_NAME]` 替换为项目名称，如 `campus-schedule-system`。

## 技术栈

> 填写示例如下，请根据实际项目修改。

- 语言 /运行时：Python 3.11 / Node.js 20
- 框架：FastAPI / React 18
- 数据库：PostgreSQL 15
- 构建工具：pnpm / webpack
- 包管理器：pnpm / pip

## 命令

> 将下面 `[command]` 替换为实际命令。

| 操作 | 命令 |
|------|------|
| 构建 | `pnpm build` |
| 测试 | `pnpm test` |
| Lint | `pnpm lint` |
| 开发服务 | `pnpm dev` |
| 类型检查 | `pnpm typecheck` |

## 代码规约

> 根据项目实际情况填写或删除不需要的项。

- 命名：PascalCase 组件，camelCase 工具函数，kebab-case 文件
- 导出：优先 named exports
- 测试位置：与源文件同目录，命名为 `*.test.ts`
- 样式：Tailwind CSS + CSS modules
- 错误处理：使用自定义 Error 类，避免直接抛出原始异常

## 边界

- 不提交 `.env` 或 secrets。
- 不在未确认影响时添加依赖。
- 修改数据库 schema 前先询问。
- 提交前必须运行测试。
- 不在生产环境直接运行未验证的命令。

## 项目级约定

> 这里可以写项目特有的规则，如 API 调用规范、数据库命名约定、前后端交互规范等。

- API 响应格式统一为 `{ code, data, message }`
- 数据库表名使用复数形式，如 `users`、`course_orders`
- 所有时间字段使用 UTC，展示时转换为东八区

## 典型模式

> 写一个简短、高质量的代码示例，体现项目风格。

```python
# 示例：简单的 FastAPI 路由处理
from fastapi import APIRouter, HTTPException

router = APIRouter(prefix="/courses", tags=["courses"])

@router.get("/{course_id}")
async def get_course(course_id: int):
    course = await course_repo.get_by_id(course_id)
    if not course:
        raise HTTPException(status_code=404, detail="Course not found")
    return {"code": 0, "data": course}
```

## 与全局 CLAUDE.md 的关系

- 全局 `~/.claude/CLAUDE.md` 提供通用最佳实践。
- 本文件提供项目级特定规则，如有冲突以本文件为准。
- 定期回顾并更新本文件，确保与项目实际一致。
