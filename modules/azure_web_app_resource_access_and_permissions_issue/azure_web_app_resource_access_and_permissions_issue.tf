resource "shoreline_notebook" "azure_web_app_resource_access_and_permissions_issue" {
  name       = "azure_web_app_resource_access_and_permissions_issue"
  data       = file("${path.module}/data/azure_web_app_resource_access_and_permissions_issue.json")
  depends_on = [shoreline_action.invoke_create_webapp_sql_conn]
}

resource "shoreline_file" "create_webapp_sql_conn" {
  name             = "create_webapp_sql_conn"
  input_file       = "${path.module}/data/create_webapp_sql_conn.sh"
  md5              = filemd5("${path.module}/data/create_webapp_sql_conn.sh")
  description      = "Create connection between webapp and database."
  destination_path = "/tmp/create_webapp_sql_conn.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_create_webapp_sql_conn" {
  name        = "invoke_create_webapp_sql_conn"
  description = "Create connection between webapp and database."
  command     = "`chmod +x /tmp/create_webapp_sql_conn.sh && /tmp/create_webapp_sql_conn.sh`"
  params      = ["APP_NAME","RESOURCE_GROUP","DATABASE_NAME","SERVER_NAME","SECRET"]
  file_deps   = ["create_webapp_sql_conn"]
  enabled     = true
  depends_on  = [shoreline_file.create_webapp_sql_conn]
}

