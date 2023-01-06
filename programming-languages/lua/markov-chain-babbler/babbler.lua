
function sanitizeIndex(index, max)
    i = index
    if index > max then
        i = index - max
    end
    return i
end

function collectTolkens(text)
    tolkens = {}
    offset = 0
    while true do 
        tolken, offset = c_collect_tolken(text, offset)
        if tolken == "" then
            break
        end
        table.insert(tolkens, tolken)
    end
    return tolkens
end

function generateNGrams(tolkens, n)
    lookup = {}
    for i = 1, #tolkens do 
        key = tolkens[i]
        for j = i+1, i+n-2 do
            key = key .. " " .. tolkens[sanitizeIndex(j, #tolkens)]
        end
        if lookup[key] == nil then
            lookup[key] = {}
        end
        table.insert(lookup[key], tolkens[sanitizeIndex(i+n-1, #tolkens)])
    end
    return lookup
end

function getRandomNGram(tolkens, n)
    nGram = {}
    startIndex = math.random(#tolkens)
    endIndex = startIndex + n-1
    for i = startIndex, endIndex do
        table.insert(nGram, tolkens[sanitizeIndex(i, #tolkens)])
    end
    return nGram
end

function nextNGram(nGram, n)
    key = nGram[2]
    nextGram = {nGram[2]}
    for j=3, n do
        key = key .. " " .. nGram[j]
        table.insert(nextGram, nGram[j])
    end
    index = math.random(#lookup[key])
    table.insert(nextGram, lookup[key][index])
    return nextGram
end

function babble(numWords, tolkens, lookup, n)
    wordCount = 0
    nGram = getRandomNGram(tolkens, n)
    while wordCount ~= numWords do
        io.write(nGram[#nGram] .. " ")
        wordCount = wordCount + 1
        nGram = nextNGram(nGram, n)
    end
    print()
end

function main(fileName, numWords, n)
    math.randomseed( os.time() )
    text = c_parse_file(fileName)
    tolkens = collectTolkens(text)
    lookup = generateNGrams(tolkens, n)
    babble(numWords, tolkens, lookup, n)
end