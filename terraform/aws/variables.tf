# variable "eks_cluster" {
#   type        = string
#   description = "Provide the name of EKS cluster"
#   default = "mgmt"
# }
variable "region" {
  type        = string
  description = "Provide the region name for example:`us-east-2` "
  default     = "us-east-2"
}
variable "vpc_id" {
  type        = string
  description = "Provide the VPC ID for example: `vpc-xxxxxxxxxx` "
  default     = "vpc-0bbeea66d3e68d55f"
}
variable "ecr_auth_token" {
  type        = string
  description = "Provide the ecr auth token"
  default     = "eyJwYXlsb2FkIjoiRkU4YmxIRDJnMDFQd3k0T1ZxUGcrY1VtQ3B0VWpNRk50ZGMrTEZKMkxhYWlPZ1N6cGxXWlpzOVRjMTNhMGprRkJkTlIxaVlzMWZzWVFkVjZoY0V0TE9Lb1pWTDdtTDVGTkNQR2hqamQvRElReS9IWkVKVTdtTDJkRzlBeHBsWTNDWFB3TTZPTERTN2VWNnBuZ2xaL1RMTXZoeUI1VndlbFVlNFZXQjJRQUJlemI2TGRRaDFEbTJ6UnkzalZESWFYQVo5cHZIcjRvQTVHUkJTWHpiSUxldEJ4cUR5RE9aeStHMStPUTFiN0luWkRLMytwUFY1SndMVTFWa0FnaDY0THJaYU9MZFIzb3R4cGY0bzkrdXlKVVNHbFEvYi9ESng4dEZVSGUxZUxsNkNnTEEraE1kTldoYkNFRnpxNnRXOEhkSGVPTjdXcXFUWGRoQVA4REtJSUN1K1JUZkpkN0FFOVVUK0RHTks2Y2JIaFh5bnYxYWJUSDV1anRhaXozQ3Z3aksya3VZR1pUbUc5YUZwc2gzNWVLd3hBNW9CUkhZaVVCNVBvMG1lNGkweXZPM0l4WTdNbTBHSThyUXp3cDFGTFNiWFYxdXBoclJoSmw4SUF6SXVVVmZ0VTVrZ1doMmRRQ3Fpb2srM1ZhTmtKZ3QrUVpmdWtGakxtem5za1JsbUNUY0xKTzFoZkxURm1RNXY2OFdRVkRzSmVXb1JjcUc4UHkwdG9Gbm94TmF2UEt6a0F5Slp4TG9aRU5QRVdFZ1F4cHZ0WTdBVDl6QzQwd0w1OHlJME83MlpuRlpDa2dodkw2bUg3bUxzRHpwZW5SZXorYVlaaFJpUU04QjFwRE53M3p0RkIyNlhMRm1Iajg1ZWo0aTQrREFoNHlrejdwNlA2QlNtaHVuRExqZjNVemYxVHRQMzNRZ0dnaTdRYUVqV2phSjhkNjRETmprYmZxNkhxQ2V0cU4zeWdNZUtyL0RUYzNuY3Y4OHIvbjBURHdnUmxnYUJIR01IK1ZXT3EvdDYvTi9aRDg1TzBrN2tnY1lWZ2NOQ0tsN0IyVUxBaXV5OFJKTVkrSGc3Mk9xVnFCSXJUdEUrWHhFRG5kZ2xSL2RoRDY4ZmczeWVheTBGNkI1bFF3c2QyRFg5Nk5iZWtqYnVFTllhOXcxRmxzaFpQbmtVUXRrUlBQVXhMc0xTZms5MjhQZys3WUlsejdkMGQ1YmF4NTdZbjdOM29YN2x3WC9mN3ZiQUZGOWE0dWxjMUJHbEFOOGF1c085NHFJUytmWHJtWnVxc3JkdnBldkNVbFJxam5Va0xRU0g4alR1dUNZYnM1dkl1Y2tXSUllanVPZDgwWUpBRTEzK24rRzhMaTlzQnowV3hLYjFHaUVnSDN1SlFEdz09IiwiZGF0YWtleSI6IkFRRUJBSGgrZFMrQmxOdTBOeG5Yd293YklMczExNXlqZCtMTkFaaEJMWnN1bk94azNBQUFBSDR3ZkFZSktvWklodmNOQVFjR29HOHdiUUlCQURCb0Jna3Foa2lHOXcwQkJ3RXdIZ1lKWUlaSUFXVURCQUV1TUJFRURBdjlZWjhVOHltME5MNWRzZ0lCRUlBN3I2Nlp1SHVKVGJ3S0RPTFRYamhRMDl6MnV1VEhYRnFLUVRDVHNVS3lDRDdsZ0F6Y1lyRy9sMGVPZW8rMmNIR1paSncrR1hranBIWUQ5TTA9IiwidmVyc2lvbiI6IjIiLCJ0eXBlIjoiREFUQV9LRVkiLCJleHBpcmF0aW9uIjoxNzAxMTM0NzUzfQ=="
}
# variable "opensearch_name" {
#   type        = string
#   description = "Provide the name of opensearch to create"
# }