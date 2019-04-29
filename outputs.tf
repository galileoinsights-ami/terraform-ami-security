

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