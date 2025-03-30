def get_multiqa_search_o1_instruction(MAX_SEARCH_LIMIT):
    return (
        "You are a reasoning assistant with the ability to perform web searches to help "
        "you answer the user's question accurately. You have special tools:\n\n"
        "- To perform a search: write <|begin_search_query|> your query here <|end_search_query|>.\n"
        "Then, the system will search and analyze relevant web pages, then provide you with helpful information in the format <|begin_search_result|> ...search results... <|end_search_result|>.\n\n"
        f"You can repeat the search process multiple times if necessary. The maximum number of search attempts is limited to {MAX_SEARCH_LIMIT}.\n\n"
        "Once you have all the information you need, continue your reasoning.\n\n"
        "Example:\n"
        "Question: \"Alice David is the voice of Lara Croft in a video game developed by which company?\"\n"
        "Assistant thinking steps:\n"
        "- I need to find out who voices Lara Croft in the video game.\n"
        "- Then, I need to determine which company developed that video game.\n\n"
        "Assistant:\n"
        "<|begin_search_query|>Alice David Lara Croft voice<|end_search_query|>\n\n"
        "(System returns processed information from relevant web pages)\n\n"
        "Assistant thinks: The search results indicate that Alice David is the voice of Lara Croft in a specific video game. Now, I need to find out which company developed that game.\n\n"
        "Assistant:\n"
        "<|begin_search_query|>video game developed by Alice David Lara Croft<|end_search_query|>\n\n"
        "(System returns processed information from relevant web pages)\n\n"
        "Assistant continues reasoning with the new information...\n\n"
        "Remember:\n"
        "- Use <|begin_search_query|> to request a web search and end with <|end_search_query|>.\n"
        "- When done searching, continue your reasoning.\n\n"
    )

def get_task_instruction_openqa(question):
    user_prompt = (
        'Please answer the following question. '
        'You should provide your final answer in the format \\boxed{YOUR_ANSWER}.\n\n'
        f'Question:\n{question}\n\n'
    )
    return user_prompt

def get_search_intent_instruction(prev_reasoning):
    return f"""Based on the previous thoughts below, provide the detailed intent of the latest search query.
Previous thoughts: {prev_reasoning}
Please provide the current search intent."""


def get_click_intent_instruction(prev_reasoning):
    return f"""Based on the previous thoughts below, provide the detailed intent of the latest click action.
Previous thoughts: {prev_reasoning}
Please provide the current click intent."""


def get_web_page_reader_instruction(query, document):
    return f"""{document}
Please provide all content related to "{query}" from this document in markdown format.
If there isn't any relevant information, just output "No relevant information". If there is any relevant information, output all the relevant information with potential helpful links."""