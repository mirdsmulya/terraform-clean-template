module "gcs" {
    source = "../../../modules/gcs"

    # general variable
    project_id                      = local.project_id
    region                          = local.region

    # gcs variable       
    bucket_name                     = local.bucket_name
}