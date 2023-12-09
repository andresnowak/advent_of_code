@value
struct TupleVar(CollectionElement, Stringable):
    var first: FloatLiteral
    var second: Int

    fn __init__(inout self, a: Int, b: Int):
        self.first = a
        self.second = b

    fn __str__(self) -> String:
        return "(" + str(self.first) + ", " + str(self.second) + ")"


# Function to find the partition position
fn partition(inout array: DynamicVector[TupleVar], low: Int, high: Int) -> Int:
    # choose the rightmost element as pivot
    let pivot = array[high]

    # pointer for greater element
    var i = low - 1

    # traverse through all elements
    # compare each element with pivot
    for j in range(low, high):
        if array[j].first <= pivot.first:
            # If element smaller than pivot is found
            # swap it with the greater element pointed by i
            i = i + 1

            # Swapping element at i with element at j
            let temp = array[i]
            array[i] = array[j]
            array[j] = temp

    # Swap the pivot element with the greater element specified by i
    let temp = array[i + 1]
    array[i + 1] = array[high]
    array[high] = temp

    # Return the position from where partition is done
    return i + 1


# function to perform quicksort


fn quickSort(inout array: DynamicVector[TupleVar], low: Int, high: Int):
    if low < high:
        # Find pivot element such that
        # element smaller than pivot are on the left
        # element greater than pivot are on the right
        let pi = partition(array, low, high)

        # Recursive call on the left of pivot
        quickSort(array, low, pi - 1)

        # Recursive call on the right of pivot
        quickSort(array, pi + 1, high)
