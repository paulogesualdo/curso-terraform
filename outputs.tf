output "bucket_name" {
  value = aws_s3_bucket.my-test-bucket.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.my-test-bucket.arn
}

output "bucket_domain_name" {
  value = aws_s3_bucket.my-test-bucket.bucket_domain_name
}

output "ips_filepath" {
  value = "${aws_s3_bucket.my-test-bucket.bucket}/${aws_s3_bucket_object.my-test-bucket-object.key}"

}