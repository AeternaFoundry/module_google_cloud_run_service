variable "cloud_run_services" {
  description = <<EOT
Map of cloud_run_services, attributes below
Required:
    - location
    - name
Optional:
    - autogenerate_revision_name
    - deletion_policy
    - project
    - metadata (block):
        - annotations (optional)
        - labels (optional)
        - namespace (optional)
    - template (block):
        - metadata (optional, block):
            - annotations (optional)
            - labels (optional)
            - name (optional)
            - namespace (optional)
        - spec (optional, block):
            - container_concurrency (optional)
            - containers (optional, block):
                - args (optional)
                - command (optional)
                - env (optional, block):
                    - name (optional)
                    - value (optional)
                    - value_from (optional, block):
                        - secret_key_ref (required, block):
                            - key (required)
                            - name (required)
                - env_from (optional, block):
                    - config_map_ref (optional, block):
                        - local_object_reference (optional, block):
                            - name (required)
                        - optional (optional)
                    - prefix (optional)
                    - secret_ref (optional, block):
                        - local_object_reference (optional, block):
                            - name (required)
                        - optional (optional)
                - image (required)
                - liveness_probe (optional, block):
                    - failure_threshold (optional)
                    - grpc (optional, block):
                        - port (optional)
                        - service (optional)
                    - http_get (optional, block):
                        - http_headers (optional, block):
                            - name (required)
                            - value (optional)
                        - path (optional)
                        - port (optional)
                    - initial_delay_seconds (optional)
                    - period_seconds (optional)
                    - timeout_seconds (optional)
                - name (optional)
                - ports (optional, block):
                    - container_port (optional)
                    - name (optional)
                    - protocol (optional)
                - readiness_probe (optional, block):
                    - failure_threshold (optional)
                    - grpc (optional, block):
                        - port (optional)
                        - service (optional)
                    - http_get (optional, block):
                        - path (optional)
                        - port (optional)
                    - period_seconds (optional)
                    - success_threshold (optional)
                    - timeout_seconds (optional)
                - resources (optional, block):
                    - limits (optional)
                    - requests (optional)
                - sandbox_launcher (optional)
                - startup_probe (optional, block):
                    - failure_threshold (optional)
                    - grpc (optional, block):
                        - port (optional)
                        - service (optional)
                    - http_get (optional, block):
                        - http_headers (optional, block):
                            - name (required)
                            - value (optional)
                        - path (optional)
                        - port (optional)
                    - initial_delay_seconds (optional)
                    - period_seconds (optional)
                    - tcp_socket (optional, block):
                        - port (optional)
                    - timeout_seconds (optional)
                - volume_mounts (optional, block):
                    - mount_path (required)
                    - name (required)
                    - sub_path (optional)
                - working_dir (optional)
            - node_selector (optional)
            - service_account_name (optional)
            - timeout_seconds (optional)
            - volumes (optional, block):
                - csi (optional, block):
                    - driver (required)
                    - read_only (optional)
                    - volume_attributes (optional)
                - empty_dir (optional, block):
                    - medium (optional)
                    - size_limit (optional)
                - name (required)
                - nfs (optional, block):
                    - path (required)
                    - read_only (optional)
                    - server (required)
                - secret (optional, block):
                    - default_mode (optional)
                    - items (optional, block):
                        - key (required)
                        - mode (optional)
                        - path (required)
                    - secret_name (required)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
    - traffic (block):
        - latest_revision (optional)
        - percent (required)
        - revision_name (optional)
        - tag (optional)
EOT

  type = map(object({
    location                   = string
    name                       = string
    autogenerate_revision_name = optional(bool)
    deletion_policy            = optional(string)
    project                    = optional(string)
    metadata = optional(object({
      annotations = optional(map(string))
      labels      = optional(map(string))
      namespace   = optional(string)
    }))
    template = optional(object({
      metadata = optional(object({
        annotations = optional(map(string))
        labels      = optional(map(string))
        name        = optional(string)
        namespace   = optional(string)
      }))
      spec = optional(object({
        container_concurrency = optional(number)
        containers = optional(list(object({
          args    = optional(list(string))
          command = optional(list(string))
          env = optional(list(object({
            name  = optional(string)
            value = optional(string)
            value_from = optional(object({
              secret_key_ref = object({
                key  = string
                name = string
              })
            }))
          })))
          env_from = optional(list(object({
            config_map_ref = optional(object({
              local_object_reference = optional(object({
                name = string
              }))
              optional = optional(bool)
            }))
            prefix = optional(string)
            secret_ref = optional(object({
              local_object_reference = optional(object({
                name = string
              }))
              optional = optional(bool)
            }))
          })))
          image = string
          liveness_probe = optional(object({
            failure_threshold = optional(number)
            grpc = optional(object({
              port    = optional(number)
              service = optional(string)
            }))
            http_get = optional(object({
              http_headers = optional(list(object({
                name  = string
                value = optional(string)
              })))
              path = optional(string)
              port = optional(number)
            }))
            initial_delay_seconds = optional(number)
            period_seconds        = optional(number)
            timeout_seconds       = optional(number)
          }))
          name = optional(string)
          ports = optional(list(object({
            container_port = optional(number)
            name           = optional(string)
            protocol       = optional(string)
          })))
          readiness_probe = optional(object({
            failure_threshold = optional(number)
            grpc = optional(object({
              port    = optional(number)
              service = optional(string)
            }))
            http_get = optional(object({
              path = optional(string)
              port = optional(number)
            }))
            period_seconds    = optional(number)
            success_threshold = optional(number)
            timeout_seconds   = optional(number)
          }))
          resources = optional(object({
            limits   = optional(map(string))
            requests = optional(map(string))
          }))
          sandbox_launcher = optional(bool)
          startup_probe = optional(object({
            failure_threshold = optional(number)
            grpc = optional(object({
              port    = optional(number)
              service = optional(string)
            }))
            http_get = optional(object({
              http_headers = optional(list(object({
                name  = string
                value = optional(string)
              })))
              path = optional(string)
              port = optional(number)
            }))
            initial_delay_seconds = optional(number)
            period_seconds        = optional(number)
            tcp_socket = optional(object({
              port = optional(number)
            }))
            timeout_seconds = optional(number)
          }))
          volume_mounts = optional(list(object({
            mount_path = string
            name       = string
            sub_path   = optional(string)
          })))
          working_dir = optional(string)
        })))
        node_selector        = optional(map(string))
        service_account_name = optional(string)
        timeout_seconds      = optional(number)
        volumes = optional(list(object({
          csi = optional(object({
            driver            = string
            read_only         = optional(bool)
            volume_attributes = optional(map(string))
          }))
          empty_dir = optional(object({
            medium     = optional(string)
            size_limit = optional(string)
          }))
          name = string
          nfs = optional(object({
            path      = string
            read_only = optional(bool)
            server    = string
          }))
          secret = optional(object({
            default_mode = optional(number)
            items = optional(list(object({
              key  = string
              mode = optional(number)
              path = string
            })))
            secret_name = string
          }))
        })))
      }))
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
    traffic = optional(list(object({
      latest_revision = optional(bool)
      percent         = number
      revision_name   = optional(string)
      tag             = optional(string)
    })))
  }))
}

