module "network" {
  source         = "./modules/network"
  Network_CIDR   = "10.0.0.0/16"
  N_subnets      = 4 
  Name           = "PHGalp-newtork" 
  Tags = {
    "Project" = "GALP-Test"
  }
}

module "golden_image" {
  source         = "./modules/golden_image"
  Name           = "PHGalpGoldenImage"
  Manifest_path  = "./manifest.json"
}

module "instances" {
  source          = "./modules/instances"
  Name            = "PH-instanceGalp"
  Network         = module.network.Network
  Image           = module.golden_image.Manifest
  SSH_key_Content = file("~/.ssh/id_rsa.pub") 
  SSH_source      = "0.0.0.0/0" 
}
