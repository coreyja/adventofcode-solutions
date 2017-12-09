def valid_passphrase?(pass_phrase)
    array = pass_phrase.split
    array.length == array.uniq.length
end

input = File.read('./input.txt')
passphrases = input.each_line.to_a

valid_passphrases = passphrases.select do |passphrase|
    valid_passphrase?(passphrase)
end

print valid_passphrases.count

