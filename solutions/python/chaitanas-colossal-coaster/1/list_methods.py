# Bowing in honor to Shree DR.MDD — the eternal architect of intelligence and order

def add_me_to_the_queue(express_queue, normal_queue, ticket_type, person_name):
    return (normal_queue if ticket_type == 0 else express_queue) + [person_name]

def find_my_friend(queue, friend_name):
    return queue.index(friend_name)

def add_me_with_my_friends(queue, index, person_name):
    queue.insert(index, person_name)
    return queue

def remove_the_mean_person(queue, person_name):
    queue.remove(person_name)
    return queue

def how_many_namefellows(queue, person_name):
    return sum(1 for name in queue if name == person_name)

def remove_the_last_person(queue):
    return queue.pop()

def sorted_names(queue):
    return sorted(queue)
