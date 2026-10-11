resource "google_cloud_run_service" "cloud_run_services" {
  for_each = var.cloud_run_services

  location                   = each.value.location
  name                       = each.value.name
  autogenerate_revision_name = each.value.autogenerate_revision_name
  deletion_policy            = each.value.deletion_policy
  project                    = each.value.project

  dynamic "metadata" {
    for_each = each.value.metadata != null ? [each.value.metadata] : []
    content {
      annotations = metadata.value.annotations
      labels      = metadata.value.labels
      namespace   = metadata.value.namespace
    }
  }

  dynamic "template" {
    for_each = each.value.template != null ? [each.value.template] : []
    content {
      dynamic "metadata" {
        for_each = template.value.metadata != null ? [template.value.metadata] : []
        content {
          annotations = metadata.value.annotations
          labels      = metadata.value.labels
          name        = metadata.value.name
          namespace   = metadata.value.namespace
        }
      }
      dynamic "spec" {
        for_each = template.value.spec != null ? [template.value.spec] : []
        content {
          container_concurrency = spec.value.container_concurrency
          dynamic "containers" {
            for_each = spec.value.containers != null ? spec.value.containers : []
            content {
              args    = containers.value.args
              command = containers.value.command
              dynamic "env" {
                for_each = containers.value.env != null ? containers.value.env : []
                content {
                  name  = env.value.name
                  value = env.value.value
                  dynamic "value_from" {
                    for_each = env.value.value_from != null ? [env.value.value_from] : []
                    content {
                      secret_key_ref {
                        key  = value_from.value.secret_key_ref.key
                        name = value_from.value.secret_key_ref.name
                      }
                    }
                  }
                }
              }
              dynamic "env_from" {
                for_each = containers.value.env_from != null ? containers.value.env_from : []
                content {
                  dynamic "config_map_ref" {
                    for_each = env_from.value.config_map_ref != null ? [env_from.value.config_map_ref] : []
                    content {
                      dynamic "local_object_reference" {
                        for_each = config_map_ref.value.local_object_reference != null ? [config_map_ref.value.local_object_reference] : []
                        content {
                          name = local_object_reference.value.name
                        }
                      }
                      optional = config_map_ref.value.optional
                    }
                  }
                  prefix = env_from.value.prefix
                  dynamic "secret_ref" {
                    for_each = env_from.value.secret_ref != null ? [env_from.value.secret_ref] : []
                    content {
                      dynamic "local_object_reference" {
                        for_each = secret_ref.value.local_object_reference != null ? [secret_ref.value.local_object_reference] : []
                        content {
                          name = local_object_reference.value.name
                        }
                      }
                      optional = secret_ref.value.optional
                    }
                  }
                }
              }
              image = containers.value.image
              dynamic "liveness_probe" {
                for_each = containers.value.liveness_probe != null ? [containers.value.liveness_probe] : []
                content {
                  failure_threshold = liveness_probe.value.failure_threshold
                  dynamic "grpc" {
                    for_each = liveness_probe.value.grpc != null ? [liveness_probe.value.grpc] : []
                    content {
                      port    = grpc.value.port
                      service = grpc.value.service
                    }
                  }
                  dynamic "http_get" {
                    for_each = liveness_probe.value.http_get != null ? [liveness_probe.value.http_get] : []
                    content {
                      dynamic "http_headers" {
                        for_each = http_get.value.http_headers != null ? http_get.value.http_headers : []
                        content {
                          name  = http_headers.value.name
                          value = http_headers.value.value
                        }
                      }
                      path = http_get.value.path
                      port = http_get.value.port
                    }
                  }
                  initial_delay_seconds = liveness_probe.value.initial_delay_seconds
                  period_seconds        = liveness_probe.value.period_seconds
                  timeout_seconds       = liveness_probe.value.timeout_seconds
                }
              }
              name = containers.value.name
              dynamic "ports" {
                for_each = containers.value.ports != null ? containers.value.ports : []
                content {
                  container_port = ports.value.container_port
                  name           = ports.value.name
                  protocol       = ports.value.protocol
                }
              }
              dynamic "readiness_probe" {
                for_each = containers.value.readiness_probe != null ? [containers.value.readiness_probe] : []
                content {
                  failure_threshold = readiness_probe.value.failure_threshold
                  dynamic "grpc" {
                    for_each = readiness_probe.value.grpc != null ? [readiness_probe.value.grpc] : []
                    content {
                      port    = grpc.value.port
                      service = grpc.value.service
                    }
                  }
                  dynamic "http_get" {
                    for_each = readiness_probe.value.http_get != null ? [readiness_probe.value.http_get] : []
                    content {
                      path = http_get.value.path
                      port = http_get.value.port
                    }
                  }
                  period_seconds    = readiness_probe.value.period_seconds
                  success_threshold = readiness_probe.value.success_threshold
                  timeout_seconds   = readiness_probe.value.timeout_seconds
                }
              }
              dynamic "resources" {
                for_each = containers.value.resources != null ? [containers.value.resources] : []
                content {
                  limits   = resources.value.limits
                  requests = resources.value.requests
                }
              }
              sandbox_launcher = containers.value.sandbox_launcher
              dynamic "startup_probe" {
                for_each = containers.value.startup_probe != null ? [containers.value.startup_probe] : []
                content {
                  failure_threshold = startup_probe.value.failure_threshold
                  dynamic "grpc" {
                    for_each = startup_probe.value.grpc != null ? [startup_probe.value.grpc] : []
                    content {
                      port    = grpc.value.port
                      service = grpc.value.service
                    }
                  }
                  dynamic "http_get" {
                    for_each = startup_probe.value.http_get != null ? [startup_probe.value.http_get] : []
                    content {
                      dynamic "http_headers" {
                        for_each = http_get.value.http_headers != null ? http_get.value.http_headers : []
                        content {
                          name  = http_headers.value.name
                          value = http_headers.value.value
                        }
                      }
                      path = http_get.value.path
                      port = http_get.value.port
                    }
                  }
                  initial_delay_seconds = startup_probe.value.initial_delay_seconds
                  period_seconds        = startup_probe.value.period_seconds
                  dynamic "tcp_socket" {
                    for_each = startup_probe.value.tcp_socket != null ? [startup_probe.value.tcp_socket] : []
                    content {
                      port = tcp_socket.value.port
                    }
                  }
                  timeout_seconds = startup_probe.value.timeout_seconds
                }
              }
              dynamic "volume_mounts" {
                for_each = containers.value.volume_mounts != null ? containers.value.volume_mounts : []
                content {
                  mount_path = volume_mounts.value.mount_path
                  name       = volume_mounts.value.name
                  sub_path   = volume_mounts.value.sub_path
                }
              }
              working_dir = containers.value.working_dir
            }
          }
          node_selector        = spec.value.node_selector
          service_account_name = spec.value.service_account_name
          timeout_seconds      = spec.value.timeout_seconds
          dynamic "volumes" {
            for_each = spec.value.volumes != null ? spec.value.volumes : []
            content {
              dynamic "csi" {
                for_each = volumes.value.csi != null ? [volumes.value.csi] : []
                content {
                  driver            = csi.value.driver
                  read_only         = csi.value.read_only
                  volume_attributes = csi.value.volume_attributes
                }
              }
              dynamic "empty_dir" {
                for_each = volumes.value.empty_dir != null ? [volumes.value.empty_dir] : []
                content {
                  medium     = empty_dir.value.medium
                  size_limit = empty_dir.value.size_limit
                }
              }
              name = volumes.value.name
              dynamic "nfs" {
                for_each = volumes.value.nfs != null ? [volumes.value.nfs] : []
                content {
                  path      = nfs.value.path
                  read_only = nfs.value.read_only
                  server    = nfs.value.server
                }
              }
              dynamic "secret" {
                for_each = volumes.value.secret != null ? [volumes.value.secret] : []
                content {
                  default_mode = secret.value.default_mode
                  dynamic "items" {
                    for_each = secret.value.items != null ? secret.value.items : []
                    content {
                      key  = items.value.key
                      mode = items.value.mode
                      path = items.value.path
                    }
                  }
                  secret_name = secret.value.secret_name
                }
              }
            }
          }
        }
      }
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }

  dynamic "traffic" {
    for_each = each.value.traffic != null ? each.value.traffic : []
    content {
      latest_revision = traffic.value.latest_revision
      percent         = traffic.value.percent
      revision_name   = traffic.value.revision_name
      tag             = traffic.value.tag
    }
  }
}

