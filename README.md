# VMGuardian: Automated Snapshot & Restore for VMs 🚀

VMGuardian automates virtual machine (VM) snapshots across AWS, GCP, and Azure, ensuring quick recovery in case of failures. It also manages snapshot retention and allows one-click restoration.

## 📌 Features

- ✔️ Supports AWS EC2, GCP Compute Engine, and Azure VMs
- ✔️ Automated scheduled snapshots for backups
- ✔️ Easy restoration from the latest snapshot
- ✔️ Auto-deletes old snapshots beyond retention days
- ✔️ Cloud-agnostic – works across multiple platforms

## 📂 Project Structure

```
📁 vmguardian/
 ├── 📄 snapshot_backup.sh     # Script to create VM snapshots
 ├── 📄 snapshot_restore.sh    # Script to restore VM snapshots
 ├── 📄 cleanup_snapshots.sh   # Script to delete old snapshots
 ├── 📄 config.env             # Configuration file for cloud settings
 ├── 📄 README.md              # Project documentation
```

## 🛠️ Prerequisites

- Linux/macOS (or Git Bash for Windows)
- Cloud CLI tools installed:
  - AWS CLI (for AWS EC2 snapshots)
  - gcloud CLI (for GCP Compute Engine)
  - Azure CLI (for Azure VMs)
- API keys configured for your cloud provider

## 🚀 Installation & Setup

1. **Clone the Repository**
   ```sh
   git clone https://github.com/Kirankumarvel/VMGuardian.git
   cd vmguardian
   ```

2. **Configure Your Cloud Credentials**
   Edit `config.env` and update:
   ```sh
   CLOUD_PROVIDER="aws"  # Change to 'gcp' or 'azure' accordingly
   INSTANCE_ID="your-instance-id"
   RETENTION_DAYS=7
   ```

3. **Make Scripts Executable**
   ```sh
   chmod +x snapshot_backup.sh snapshot_restore.sh cleanup_snapshots.sh
   ```

## 💾 Creating Snapshots

To manually create a snapshot:
```sh
./snapshot_backup.sh
```

## 📅 Automate with Cron Jobs

To run the script daily at 2 AM:
```sh
crontab -e
```

Add this line:
```sh
0 2 * * * /path/to/vmguardian/snapshot_backup.sh >> /var/log/vm_snapshot.log 2>&1
```

## 🔄 Restoring from Snapshot

To restore the latest snapshot:
```sh
./snapshot_restore.sh
```

## 🗑️ Cleanup Old Snapshots

To delete snapshots older than retention days:
```sh
./cleanup_snapshots.sh
```

## 📜 Future Enhancements

- 🔹 Add email notifications after each snapshot
- 🔹 Store logs in a database for analytics
- 🔹 Implement a user-friendly CLI menu

## 📌 Contributing

Feel free to submit issues, pull requests, and suggestions!

## 📃 License

MIT License © 2025 Kiran Kumar

---

🚀 Secure your cloud VMs effortlessly with VMGuardian!
