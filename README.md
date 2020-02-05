# Minecraft

## Backup

```bash
kubectl cp <pod_name>:/mc_data <backup>
```

## Restore

```bash
kubectl cp <backup> <pod_name>:/mc_data
```