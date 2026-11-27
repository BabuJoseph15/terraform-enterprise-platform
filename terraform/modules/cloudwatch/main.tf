resource "aws_cloudwatch_metric_alarm" "ecs_cpu_high" {
  alarm_name = "${var.project_name}-${var.environment}-ecs-high-cpu"

  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1

  metric_name = "CPUUtilization"
  namespace   = "AWS/ECS"

  period    = 300
  statistic = "Average"

  threshold = 80

  alarm_description = "ECS CPU Utilization > 80%"

  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = var.ecs_service_name
  }
}
resource "aws_cloudwatch_metric_alarm" "ecs_memory_high" {
  alarm_name = "${var.project_name}-${var.environment}-ecs-high-memory"

  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1

  metric_name = "MemoryUtilization"
  namespace   = "AWS/ECS"

  period    = 300
  statistic = "Average"

  threshold = 80

  alarm_description = "ECS Memory Utilization > 80%"

  dimensions = {
    ClusterName = var.ecs_cluster_name
    ServiceName = var.ecs_service_name
  }
}
resource "aws_cloudwatch_metric_alarm" "alb_unhealthy_hosts" {
  alarm_name = "${var.project_name}-${var.environment}-alb-unhealthy-hosts"

  comparison_operator = "GreaterThanThreshold"

  evaluation_periods = 1

  metric_name = "UnHealthyHostCount"

  namespace = "AWS/ApplicationELB"

  period    = 60
  statistic = "Average"

  threshold = 0

  alarm_description = "ALB Unhealthy Host Count > 0"

  dimensions = {
    LoadBalancer = var.load_balancer_arn_suffix
    TargetGroup  = var.target_group_arn_suffix
  }
}
