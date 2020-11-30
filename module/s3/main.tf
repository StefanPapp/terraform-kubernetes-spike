resource "aws_s3_bucket" "backup_bucket" {
  bucket = format("%s-backup", var.cluster_name)
  acl    = "private"

  tags = {
    Name         = format("%s-backup-bucket", var.cluster_name)
    Purpose      = format("%s-k8s", var.cluster_name)
    Department   = format("%s", var.tag_account)
    Creator      = format("%s", var.tag_creator)
    Date_Created = format("%s", var.run_date)
  }

  lifecycle_rule {
    id      = "14DayBackupDelete"
    expiration {
      days = 14
    }
    enabled = false
  }
}