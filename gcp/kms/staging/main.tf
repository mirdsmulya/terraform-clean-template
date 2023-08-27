module "kms" {
    source = "../../modules/kms"

    # general variable
    project_id                      = local.project_id
    region                          = local.region

    # kms variable       
    keyring                         = local.keyring
    keys                            = local.keys
}