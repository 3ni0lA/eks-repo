
# Lets Encrypt Certificate                                                                                                                  


resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "registration" {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = "devprecious@gmail.com" # TODO put your own email in here!
}

resource "acme_certificate" "certificate" {
  account_key_pem           = acme_registration.registration.account_key_pem
  common_name               = "eniola.link"
  # subject_alternative_names = "eniola.live"

  dns_challenge {
    provider = "route53"


      
    config = {
      AWS_ACCESS_KEY_ID     = var.aws_access_key
      AWS_SECRET_ACCESS_KEY = var.aws_secret_key
      AWS_DEFAULT_REGION    = "eu-west-2" 
    }
}

  }
 

output "certificate_pem" {
  value = lookup(acme_certificate.certificate, "certificate_pem")
}
output "issuer_pem" {
  value = lookup(acme_certificate.certificate, "issuer_pem")
}
output "private_key_pem" {
  value = nonsensitive(lookup(acme_certificate.certificate, "private_key_pem"))
}














