output "jenkins_url" {
  description = "Jenkins Web URL"
  value       = "http://${aws_instance.my_ec2.public_ip}:8080"
}