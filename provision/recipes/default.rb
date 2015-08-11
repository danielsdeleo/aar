
context = ChefDK::ProvisioningData.context

with_driver 'vagrant:~/.vagrant.d/boxes' do

  options = {
    vagrant_options: {
      'vm.box' => 'opscode-ubuntu-14.04',
      'vm.network' => ":forwarded_port, guest: 80, host: 8080"
    },
    convergence_options: context.convergence_options
  }


  machine context.node_name do
    machine_options(options)

    # This forces a chef run every time, which is sensible for `chef provision`
    # use cases.
    converge(true)
    action(context.action)
  end
end
