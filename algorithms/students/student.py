

class Student:
    def __init__(self, f_name, l_name, ssn, email, age):
        self.f_name = f_name
        self.l_name = l_name
        self.ssn = ssn
        self.email = email
        self.age = age
    def getFirstName(self):
        return self.f_name
    def getLaseName(self):
        return self.l_name
    def getSSN(self):
        return self.ssn
    def getEmail(self):
        return self.email
    def getAge(self):
        return self.age

    def __lt__(self, other):
        if self.ssn < other.ssn:
            return True
        else:
            return False

    def __gt__(self, other):
        if other < self:
            return True
        else:
            return False
    def __eq__(self, other):
        if not (self < other or other < self):
            return True
        else:
            return False       
    def __ne__(self, other):
        if self < other or other < self:
            return True
        else:
            return False
    def __le__(self, other):
        if self < other or self == other:
            return True
        else:
            return False
    def __ge__(self, other):
        if other < self or self == other:
            return True
        else:
            return False

    def __int__(self):
        ssn = self.ssn.replace('-','')
        return int(ssn)

