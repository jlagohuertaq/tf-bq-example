resource "google_bigquery_table" "sheet" {
  dataset_id = google_bigquery_dataset.default.dataset_id
  table_id   = "sheet"

  external_data_configuration {
    autodetect    = true
    source_format = "GOOGLE_SHEETS"

    google_sheets_options {
      skip_leading_rows = 1
    }

    source_uris = [
      "https://docs.google.com/spreadsheets/d/123456789012345",
    ]
  }
}

data "google_iam_policy" "admin" {
  binding {
    role = "roles/bigquery.dataOwner"
    members = [
      "user:jane@example.com",
    ]
  }
}

resource "google_bigquery_table_iam_policy" "policy" {
  project = google_bigquery_table.test.project
  dataset_id = google_bigquery_table.test.dataset_id
  table_id = google_bigquery_table.test.table_id
  policy_data = data.google_iam_policy.admin.policy_data
}


resource "google_bigquery_table_iam_member" "member" {
  project = google_bigquery_table.test.project
  dataset_id = google_bigquery_table.test.dataset_id
  table_id = google_bigquery_table.test.table_id
  role = "roles/bigquery.dataOwner"
  member = "user:jane@example.com"
}