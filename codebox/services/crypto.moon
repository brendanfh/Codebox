bcrypt = require "bcrypt"

ROUNDS = 10

{
	encrypt: (data) ->
		bcrypt.digest(data, ROUNDS)

	verify: (data, digest) ->
		bcrypt.verify(data, digest)
}

