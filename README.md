# Mastering Loops and Conditionals in Terraform



Replace any repeated resource blocks with for_each
Use count = var.some_bool ? 1 : 0 to make optional resources toggleable
Use a for expression in at least one output to produce a useful map
Use locals to centralise conditional logic rather than scattering ternary operators through resource arguments


            # Auto Scaling Group (Cluster Core)
            resource "aws_autoscaling_group" "app_asg" {
              name                = "${var.cluster_name}-asg"
              desired_capacity    = var.min_size
              min_size            = var.min_size
              max_size            = var.max_size
              vpc_zone_identifier = [for s in aws_subnet.public : s.id]
              launch_template {
                id      = aws_launch_template.app_lt.id
                version = "$Latest"
              }
            
              target_group_arns = [aws_lb_target_group.app_tg.arn]
              health_check_type         = "ELB"
              health_check_grace_period = 60
            
              tag {
                key                 = "Name"
                value               = var.cluster_name
                propagate_at_launch = true
              }
            
              dynamic "tag" {
                for_each = var.custom_tags
                content {
                  key                 = tag.key
                  value               = tag.value
                  propagate_at_launch = true
                }
              }
              
            }

          resource "aws_subnet" "public" {
            for_each = var.public_subnets
          
            vpc_id                  = data.aws_vpc.default.id
            cidr_block              = each.value
            availability_zone       = "${var.aws_region}${each.key}"
            map_public_ip_on_launch = true
          
            tags = {
              Name = "${var.cluster_name}-public-${each.key}"
            }
          }
