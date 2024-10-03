terraform {
    source = ".//module"

    extra_arguments "parallelism" {
      commands  = ["apply"]
      arguments = ["-parallelism=${get_env("TF_VAR_parallelism", "10")}"]
    }
}

inputs = {
  sshkey = "testbed-key"
  videoserver_image = "atb-videoserver-image-2024-07-09T11-00-42Z"
  adminpc_image = "atb-adminpc-image-2024-07-03T11-47-38Z"
  adminpc3_image = "atb-adminpc3-image-2024-09-21T15-33-18Z"
  attacker_image = "atb-attacker-image-2024-07-03T11-58-41Z"
  ghostsserver_image = "atb-ghostsserver-image-2024-07-18T12-38-17Z"
}


include {
  path = find_in_parent_folders()
}
