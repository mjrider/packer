// a run starts resources to provision them.
build "base-image-and-something" {

    shell {
        inline = [
            "echo '{{user `my_secret`}}' :D"
        ]
    }
    
    shell {
        script = [
            "script-1.sh",
            "script-2.sh",
        ]
        override "vmware-iso" {
            execute_command = "echo 'password' | sudo -S bash {{.Path}}"
        }
    }

    store  {
        amazon-ebs "{{user `image_name`}}" {} // save ami from this point
        
        virtualbox-iso "{{user `image_name`}}" {}
        // shutdown machine & export it to default settings.
        
        // storing should always be the last step for vms
    }

    upload "foo.go" "/tmp" {}

    upload "log.go" "/tmp" {
        timeout = "5s"
    }

}
