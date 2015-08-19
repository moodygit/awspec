#!/usr/bin/env ruby

require 'awspec'

Aws.config[:stub_responses] = true

types = %w(ec2 rds auto_scaling_group)
links = types.map do |type|
  '[' + type + '](#' + type + ')'
end
header = <<-'EOF'
## Resource Types

<%= links.join('|') %>

EOF
puts ERB.new(header, nil, '-').result(binding)

types.map do |type|
  puts eval "Awspec::Generator::Doc::#{type.to_camel_case}.new.generate_doc"
end
