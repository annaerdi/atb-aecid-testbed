# AdminPC 3

## Configuration

This packer-config generates adminpc image. 
On this adminpc, a ghostagent is automatically started as a service.
The timeline of the user simulation is defined in `playbook/templates/timeline.j2`.
By default, the simulated user logs into the ZoneMinder interface once with the provided credentials, 
and then continuously clicks through various links within the application, maintaining the logged-in session.

## Prebuild

Create a default.json:

```
{
    "base_image" : "Ubuntu 22.04",
    "image_name" : "adminpc3-image",
    "security_group": "default",
    "network": "9c480f42-62f2-4f08-a961-38c28fa19346",
    "floating_ip_pool": "provider-aecid-208"
}
```

## Install requirements

```
ansible-galaxy install -r playbook/requirements.yml
```

## Build

```
packer build -var-file=default.json .
```
