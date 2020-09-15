class Solution:
    def intToRoman(self, num: int) -> str:
        roman_string = ''
        while num>0:
            print(num)
            if num/1000>=1:
                roman_string += 'M'
                num-=1000
            elif num/900>=1:
                roman_string += 'CM'
                num-=900
            elif num/500>=1:
                roman_string += 'D'
                num-=500
            elif num/400>=1:
                roman_string += 'CD'
                num-=400
            elif num/100>=1:
                roman_string += 'C'
                num-=100
            elif num/90>=1:
                roman_string += 'XC'
                num-=90
            elif num/50>=1:
                roman_string += 'L'
                num-=50
            elif num/40>=1:
                roman_string += 'XL'
                num-=40
            elif num/10>=1:
                roman_string += 'X'
                num-=10
            elif num/9>=1:
                roman_string += 'IX'
                num-=9
            elif num/5>=1:
                roman_string += 'V'
                num-=5
            elif num/4>=1:
                roman_string += 'IV'
                num-=4
            elif num/4>=1:
                roman_string += 'I'
                num-=1
        return roman_string

print(Solution().intToRoman(789))
