Birthday paradox
================

The *birthday paradox* concerns the probability that two people in a
group of *n* randomly chosen people will share a birthday. It is
called a paradox only because the results are sometimes surprising.
For example, the probability of two people sharing a birthday is
greater than 50% with a mere 23 people, and is greater than 90% with
41 people.

In this problem you will compute the probability that two people in
a randomly selected group of *n* people share a birthday. You will
write the function:

    birthday(n) -> p

Where *n* is the number of people, and the value of *p* that it
returns is the probability that at least two people in the group
share a birthday (expressed as a value from 0 to 100 and rounded to
the nearest integer).

You can calculate this iteratively by computing the probability that
no two people share a birthday. Note that probabilities are normally
computed between 0.0 and 1.0:

*   If there is one person, the probability of having a unique
    birthday is 1.0 (no chance of sharing it with anyone).

*   When you add a second person, the only way to avoid a collision
    (the term for when two birthdays coincide) is for that persons
    birthday to be one of the 364 days not already taken, so the
    chance of the second person having a unique birthday is 364÷365.

*   When you add the third person, the probability of being
    collision free relies on two things:

    1.  No collisions have occurred so far (364÷365 chance).
    2.  The new person has a birthday in one of the 363 remaining
        days (363÷365 chance).

    Multiply these together to get the probability that all three
    have unique birthdays.

*   When you add a fourth person, being collision free requires:

    1.  No collisions have occurred so far (probability worked out
        for the third person).
    2.  The new person has a birthday in one of the 362 remaining
        days (362÷365 chance).

and so on. We can write this in Python:

``` python
def birthday(n):
    p = 1.0
    for i in range(n):
        unusedDays = 365 - i
        p = p * (float(unusedDays) / 365.0)
    chanceOfCollision = (1.0 - p) * 100.0
    return int(round(chanceOfCollision))
```

In the main loop, we compute the probability that no collision
occurs. To get the probability that a collision *has* occurred, we
just subtract from 1.0. To give that value as a percentage, we
mulitply by 100.0. We then round it to the nearest integer and
return the result.


Floating point hints
--------------------

Implement the Python code given above as an assembly language
function. Pay careful attention to which values are integers and
which are floats, and convert as needed. To convert a float to an
integer by rounding to the nearest value, use:

    ftosid s0, d0       @ round d0 to an integer and store in s0
    vmov r0, s0         @ copy integer value from s0 to r0

Everything else involves instructions and ideas that you have
already practiced in homework assignments.
