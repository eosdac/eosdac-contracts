
# Creates accounts on a local chain using `cleos` using the a deterministic list of account names based on `generate_account_names`.
#
# == Parameters:
#   An array of account names to add to the chain
#
def create_accounts(accounts)
  ownerPrivatekey = "5JioEXzAEm7yXwu6NMp3meB1P4s4im2XX3ZcC1EC5LwHXo69xYS"
  ownerPublickey = "EOS7FuoE7h4Ruk3RkWXxNXAvhBnp7KSkq3g2NpYnLJpvtdPpXK3v8"
  activePrivatekey = "5JHo6cvEc78EGGcEiMMfNDiTfmeEbUFvcLEnvD8EYvwzcu8XFuW"
  activePublickey = "EOS4xowXCvVTzGLr5rgGufqCrhnj7yGxsHfoMUVD4eRChXRsZzu3S"
  puts `cleos wallet import #{ownerPrivatekey}`
  puts `cleos wallet import #{activePrivatekey}`

  accounts.each do |acc|
    puts `cleos create account eosio #{acc} #{ownerPublickey} #{activePublickey}`
  end
end

def add_accounts_as_members(num)

  accounts = generate_account_names(num)
  params = accounts.each_with_index.map { |acc, i| %(["#{acc}", "0.0001 ABC"]) }.join(', ')

  puts `cleos push action eosdactoken memberadda '{"newmembers":[#{params}], "memo":"air drop balance"}' -p eosdactoken`
end
# create_accounts(30) # Need to only run this line once.
# add_accounts_as_members(30) # The most I could add in one transaction locally was around 250.