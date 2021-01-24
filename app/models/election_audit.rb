# In real life, I probably wouldn't write this data to the main database.
# Audit trails should be write-once and *never* updated after the fact.
# Thus, we don't need the ACID-level updateability that an RDBMS provides.
#
# Combined with the fact that these audits will effectively double the number
# of writes, it's likely that ElectionAudit should be persisted to something
# else (perhaps something like AWS kinesis, S3, or even flat log files).
#
# Changing the audit persistence mechansism may also give us the opportunity
# to do some sort of cryptographic validation (ie: digital signatures.)
# If this was 2015, I might even propose blockchain (and then call my broker).
#
# However, for this challenge, saving ElectionAudit to its own table is good enough.
class ElectionAudit < ApplicationRecord
  belongs_to :election
  belongs_to :user
end
