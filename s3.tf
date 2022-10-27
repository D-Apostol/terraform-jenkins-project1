module "web_app_s3" {
  source = "./modules/adobo-web-app-s3"

  bucket_name             = local.s3_bucket_name
  elb_service_account_arn = data.aws_elb_service_account.root.arn
  common_tags             = local.common_tags
}


resource "aws_s3_bucket_object" "website" {
  for_each = {
    website     = "/website/index.html"
    styles      = "/website/resources/css/styles.css"
    reset       = "/website/resources/css/reset.css"
    adobo1      = "/website/resources/images/adobo1.jpg"
    adobo2      = "/website/resources/images/adobo2.jpeg"
    filipinoman = "/website/resources/images/filipinoman.jpg"
    karekare    = "/website/resources/images/karekare.jpg"
    lechon      = "/website/resources/images/lechon.jpg"
    logo        = "/website/resources/images/lechon.jpg"
    lumpia      = "/website/resources/images/lumpia.jpg"
    pancit      = "/website/resources/images/pancit.jpg"
  }
  bucket = module.web_app_s3.web_bucket.id
  key    = each.value
  source = ".${each.value}"

  tags = local.common_tags
}