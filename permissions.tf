resource "google_bigquery_dataset_iam_binding" "reader" {
  dataset_id = "your-dataset-id"
  role       = "roles/bigquery.dataViewer"

  members = [
    "user:jane@example.com",
  ]
}

