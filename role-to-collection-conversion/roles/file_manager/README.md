# File Manager Role

This Ansible role manages files and directories with various options and configurations.

## Features

- Create directory structures with custom permissions
- Create configuration files from templates
- Create files with custom content
- Copy files from source to destination
- Create symbolic links
- Handle OS-specific configurations

## Requirements

- Ansible 2.9 or higher

## Role Variables

See `defaults/main.yml` for all configurable variables.

## Dependencies

None

## Example Playbook

```yaml
- hosts: servers
  roles:
    - role: file_manager
      vars:
        file_manager_owner: "app_user"
        file_manager_group: "app_group"
        file_manager_directories:
          - path: "/opt/myapp/data"
            mode: "0750"
          - path: "/opt/myapp/logs"
            mode: "0755"
        file_manager_template_files:
          - src: "app.conf.j2"
            dest: "/opt/myapp/config/app.conf"
```

## License

MIT

## Author Information

Example Author