A easy to way to inform others about your schedule of any location.

So we can just use timemachine2 for our case. If you just want to change to local, you don't have to use any package.

## Schema design

Make sure to add update date in `updated_at` on your current dateTime in UTC format.

```json
{
  "version": 1,
  "updated_at": "YourEditingDateTime in UTC format",
  "data": []
}
```
