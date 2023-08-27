module "cloudsql" {
    source = "../../modules/cloudsql"

    # general variable
    project_id                      = local.project_id
    region                          = local.region
    network_name                    = local.network_name
    env                             = local.env

    # Cloudsql variable       
    cloudsql_name                   = local.cloudsql_name
    delete_protection               = local.delete_protection
    database_version                = local.database_version
    tier_spec                       = local.tier_spec
    availability_type               = local.availability_type
    disk_size                       = local.disk_size
    initial_db_name                 = local.initial_db_name
    initial_db_user                 = local.initial_db_user
}