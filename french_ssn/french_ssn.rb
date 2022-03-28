# ^[12] ?\d{2} ?(0[1-9]|1[0-2]) ?\d{2} ?\d{3} ?\d{3} ?\d{2}$
# 1 84 12 76 451 089 46
# 285037645108994
require 'date'
require 'yaml'

# 1. CREATE REGEX
SSN_PATTERN = /(?<gender>[12]) ?(?<year>\d{2}) ?(?<month>(0[1-9]|1[0-2])) ?(?<department>(\d[1-9]|[1-9]0)) ?(\d{3} ?){2}\d{2}/

def french_ssn_info(ssn)
  match_data = ssn.match(SSN_PATTERN)
  # 2 & 3. VALIDATE FORMAT & KEY
  if match_data && valid_key?(ssn)
    # 4. DATA EXTRACTION
    gender = gender(match_data[:gender])
    month = month(match_data[:month])
    year = "19#{match_data[:year]}"
    department = department(match_data[:department])
    # 5. CREATE MESSAGE
    return "a #{gender}, born in #{month}, #{year} in #{department}."
  end
  'The number is invalid'
end

def gender(code)
  code == '1' ? 'man' : 'woman'
end

def month(code)
  Date::MONTHNAMES[code.to_i]
end

def department(code)
  department_hash = YAML.load_file('data/french_departments.yml')
  department_hash[code]
end

def valid_key?(ssn)
  ssn_without_spaces = ssn.delete(' ')
  ssn_without_key = ssn_without_spaces[0..12].to_i
  key = ssn_without_spaces[13..14].to_i
  97 - ssn_without_key % 97 == key
end

# Valid ssn numbers
# p french_ssn_info('1 84 12 76 451 089 46')
# p french_ssn_info('285037545008855')
# p valid_key?("1 84 12 76 451 089 46")
# p valid_key?("285037545008855")
# Invalid ssn numbers
# p french_ssn_info('1 84 12 76 451 089 43')
# p valid_key?("1 84 12 76 451 089 43")

# french_ssn_info('1 84 12 76 451 089 46')
# french_ssn_info('285037545008855')
# french_ssn_info('1 84 12 76 451 089 43')
# french_ssn_info('')
