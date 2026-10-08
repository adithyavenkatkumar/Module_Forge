resource "aws_lb" "lb" {
  name               = var.name
  internal           = var.internal
  load_balancer_type = var.load_balancer_type
  security_groups    = var.security_groups
  subnets            = var.subnets
  tags               = merge(var.tags, { Name = var.name })
}

resource "aws_lb_target_group" "tg" {
  for_each    = var.target_groups
  name        = each.key
  port        = each.value.port
  protocol    = each.value.protocol
  vpc_id      = var.vpc_id
  target_type = lookup(each.value, "target_type", "instance")

  health_check {
    path                = lookup(each.value, "health_check_path", "/")
    protocol            = lookup(each.value, "health_check_protocol", "HTTP")
    port                = lookup(each.value, "health_check_port", "traffic-port")
    healthy_threshold   = lookup(each.value, "healthy_threshold", 3)
    unhealthy_threshold = lookup(each.value, "unhealthy_threshold", 3)
  }

  tags = merge(var.tags, { Name = each.key })
}

resource "aws_lb_listener" "listener" {
  for_each          = var.listeners
  load_balancer_arn = aws_lb.lb.arn
  port              = each.value.port
  protocol          = each.value.protocol

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg[each.value.target_group_key].arn
  }
}
