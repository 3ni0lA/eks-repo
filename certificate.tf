
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
  common_name               = ""
  # subject_alternative_names = ""

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














# resource "acme_certificate" "ekstls_cert" {
#   account_key_pem = file("devprecious.key")
#   csr       = base64encode(file("certificate.csr"))
#   common_name     = "eniola.live"
#   subject_alternative_names = [
#     "www.eniola.live",

#   ]
#   challenge_type = "dns-01"
# }

# resource "acme_certificate" "ekstls_cert" {
#   common_name               = "eniola.live"
#   subject_alternative_names = ["www.eniola.live"]

#   account_key_pem = file("${path.module}/devprecious.key")

#   csr = file("${path.module}/certificate.csr")

#   dns_challenge {
#     provider = "dnsimple"
#   }
# }















# resource "acme_registration" "letsencrypt" {
#   email_address = "devprecious@gmail.com"
# }

# resource "acme_certificate" "ekstls" {
#   account_key_pem = file("devprecious.key")
#   common_name     = "eniola.live"
#   subject_alternative_names = [
#     "www.eniola.live",
#   ]

#   dns_challenge {
#     provider = "dnsimple"
#     config = {
#       DNSIMPLE_API_EMAIL = "devprecious@gmail.com"


#     }
#   }

#   resource "dnsimple_record" "www" {
#   domain = "eniola.live"
#   name   = "www"
#   type   = "A"
#   ttl    = 300
#   value  = "203.0.113.10"


#   }

# }
