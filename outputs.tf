output "infrastructure_admin_key_name" {
  description = "Key name of the Infrastructure Admin Keypair"
  value = "${aws_key_pair.infrastructure_admin.key_name}"
}

output "infrastructure_admin_key_fingerprint" {
  description = "Fingerprint of the Infrastructure Admin Keypair"
  value = "${aws_key_pair.infrastructure_admin.fingerprint}"
}


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

output "TFBastion_access_key" {
  description = "TFBastion User Access Key"
  value = "${module.tfbastion_user.this_iam_access_key_id}"
}

output "TFBastion_encrypted_base64_secret" {
  description = "TFBastion User encrypted secret, base64 encoded"
  value = "${module.tfbastion_user.this_iam_access_key_encrypted_secret}"
}

output "TFBastion_keybase_secret_key_decrypt_command" {
  description = "Command to decrypt TFBastion Secret Key"
  value = "${module.tfbastion_user.keybase_secret_key_decrypt_command}"
}


output "TFRoute53_access_key" {
  description = "TFRoute53 User Access Key"
  value = "${module.tfroute53_user.this_iam_access_key_id}"
}

output "TFRoute53_encrypted_base64_secret" {
  description = "TFRoute53 User encrypted secret, base64 encoded"
  value = "${module.tfroute53_user.this_iam_access_key_encrypted_secret}"
}

output "TFRoute53_keybase_secret_key_decrypt_command" {
  description = "Command to decrypt TFRoute53 Secret Key"
  value = "${module.tfroute53_user.keybase_secret_key_decrypt_command}"
}


output "TFCertificateManager_access_key" {
  description = "TFCertificateManager User Access Key"
  value = "${module.tfcertificatemanager_user.this_iam_access_key_id}"
}

output "TFCertificateManager_encrypted_base64_secret" {
  description = "TFCertificateManager User encrypted secret, base64 encoded"
  value = "${module.tfcertificatemanager_user.this_iam_access_key_encrypted_secret}"
}

output "TFCertificateManager_keybase_secret_key_decrypt_command" {
  description = "Command to decrypt TFCertificateManager Secret Key"
  value = "${module.tfcertificatemanager_user.keybase_secret_key_decrypt_command}"
}