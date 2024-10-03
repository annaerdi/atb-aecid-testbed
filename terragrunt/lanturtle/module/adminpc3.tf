locals {
    ext_adminpc3_userdata_file = var.adminpc3_userdata == null ? "${path.module}/scripts/default.yml" : var.adminpc3_userdata
}

####################################################################
#
# CREATE INSTANCE for "VIDEOSERVER"
#
data "template_file" "userdata_adminpc3" {
  template = "${file("${local.ext_adminpc3_userdata_file}")}"
}

data "template_cloudinit_config" "cloudinitadminpc3" {
  count         = local.ext_adminpc3_userdata_file == null ? 0 : 1
  gzip          = false
  base64_encode = false

  part {
    filename     = "init.cfg"
    content_type = "text/cloud-config"
    content      = data.template_file.userdata_adminpc3.rendered
  }
}

data "openstack_images_image_v2" "adminpc3-image" {
  name        = var.adminpc3_image
  most_recent = true
}

resource "openstack_compute_instance_v2" "adminpc3" {
  name        = "adminpc3"
  flavor_name = var.adminpc3_flavor
  key_pair    = var.sshkey
  image_id    = data.openstack_images_image_v2.adminpc3-image.id
  user_data    = local.ext_adminpc3_userdata_file == null ? null : data.template_cloudinit_config.cloudinitadminpc3[0].rendered

  network {
    name = "lan"
    fixed_ip_v4 = cidrhost(var.lan_cidr,223)
  }

}
