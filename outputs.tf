

output "TFNetwork_access_key" {
  description = "TFNetwork User Access Key"
  value = "${module.tfnetwork_user.this_iam_access_key_id}"
}

output "TFNetwork_encrypted_base64_secret" {
  description = "TFNetwork User encrypted secret, base64 encoded"
  value = "${module.tfnetwork_user.this_iam_access_key_encrypted_secret}"
}

output "TFNetwork_keybase_secret_key_decrypt_command" {
  description = "Command to decrypt TFNetwork Secret Key"
  value = "${module.tfnetwork_user.keybase_secret_key_decrypt_command}"
}


output "TFRds_access_key" {
  description = "TFRds User Access Key"
  value = "${module.tfrds_user.this_iam_access_key_id}"
}

output "TFRds_encrypted_base64_secret" {
  description = "TFRds User encrypted secret, base64 encoded"
  value = "${module.tfrds_user.this_iam_access_key_encrypted_secret}"
}

output "TFRds_keybase_secret_key_decrypt_command" {
  description = "Command to decrypt TFRds Secret Key"
  value = "${module.tfrds_user.keybase_secret_key_decrypt_command}"
}


output "TFLoadBalancer_access_key" {
  description = "TFLoadBalancer User Access Key"
  value = "${module.tfloadbalancer_user.this_iam_access_key_id}"
}

output "TFLoadBalancer_encrypted_base64_secret" {
  description = "TFLoadBalancer User encrypted secret, base64 encoded"
  value = "${module.tfloadbalancer_user.this_iam_access_key_encrypted_secret}"
}

output "TFLoadBalancer_keybase_secret_key_decrypt_command" {
  description = "Command to decrypt TFLoadBalancer Secret Key"
  value = "${module.tfloadbalancer_user.keybase_secret_key_decrypt_command}"
}

output "infrastructure_admin_key_name" {
  description = "Key name of the Infrastructure Admin Keypair"
  value = "${aws_key_pair.infrastructure_admin.key_name}"
}

output "infrastructure_admin_key_fingerprint" {
  description = "Fingerprint of the Infrastructure Admin Keypair"
  value = "${aws_key_pair.infrastructure_admin.fingerprint}"
}