
resource "aws_s3_bucket" "example" {
  bucket = "chisom-newest-bucket2424" #enter a unique bucket name
  

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
    
  }

}
