terraform{
  required_providers{
    azurerm={
      source="hashicorp/azurerm"
      version= ">=3.70.0"#this version is for azurerm, NOT terraform version
    }
  }
  required_version=">=1.4.0"#this version is for Terraform Version, NOT azurerm
}

provider "azurerm"{
  features{}
  skip_provider_registration="true"
  
  subscription_id=var.subscription_id
  client_id=var.client_id
  client_secret=var.client_secret
  tenant_id=var.tenant_id
}
variable "subscription_id"{
  type=string
}
variable "client_id"{
  type=string
}
variable "client_secret"{
  type=string
}
variable "tenant_id"{
  type=string
}
variable "account_tier"{
  type=string
  default="Standard"
}
variable "access_tier"{
  type=string
  default="Cool"
}
variable "account_replication_type"{
  type=string
  default="GRS"
}
variable "cross_tenant_replication_enabled"{
 type=bool
 default=false
}
variable "environment"{
 type=string
 default="staging"
}
variable "linuxappconfiguration"{
 type=string
 default="linuxappconfiguration"
}
