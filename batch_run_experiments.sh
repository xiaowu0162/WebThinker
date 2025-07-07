#!/bin/bash

export PYTHONPATH=${PYTHONPATH}:'/fsx-comem/diwu0162/WebThinker'


model_name=$1 # "Qwen/QwQ-32B"
server_base=$2 # "http://localhost:8001/v1"
subset=$3

SERPER_API_KEY=`cat serper_api_key.txt`

# dataset sizes
# amc - 40
# aime - 30
# math500 - 500
# livecode_1to4 - 112
# bamboogle - 125
# musique/nq/triviaqa/hotpotqa/2wiki - 500



##############################################################################
# Run direct generation evaluation
##############################################################################
if [ $subset == "xxx" ]; then
    python scripts/run_direct_gen.py --api_base_url "http://localhost:8001/v1" --model_name "Qwen/QwQ-32B"  --dataset_name 'gaia' --split 'dev' --eval
fi



##############################################################################
# Run Vanilla RAG evaluation
##############################################################################
if [ $subset == "xxx" ]; then
    python scripts/run_naive_rag.py --api_base_url "http://localhost:8001/v1" --model_name "Qwen/QwQ-32B"  --dataset_name 'gpqa' --split 'diamond' --eval --search_engine "serper" --serper_api_key `cat serper_api_key.txt` 
fi

##############################################################################
# Run Search-o1 evaluation
##############################################################################
if [ $subset == "xxx" ]; then
    python scripts/run_search_o1.py --api_base_url "http://localhost:8001/v1" --model_name "Qwen/QwQ-32B"  --dataset_name 'gpqa' --split 'diamond' --eval --search_engine "serper" --serper_api_key `cat serper_api_key.txt` 
    python scripts/run_search_o1.py --api_base_url "http://localhost:8001/v1" --model_name "Qwen/QwQ-32B"  --dataset_name 'gaia' --split 'dev' --eval --search_engine "serper" --serper_api_key `cat serper_api_key.txt` 
    python scripts/run_search_o1.py --api_base_url "http://localhost:8001/v1" --model_name "Qwen/QwQ-32B"  --dataset_name 'aime' --split 'test' --eval --search_engine "serper" --serper_api_key `cat serper_api_key.txt` 
    python scripts/run_search_o1.py --api_base_url "http://localhost:8001/v1" --model_name "Qwen/QwQ-32B"  --dataset_name 'amc' --split 'test' --eval --search_engine "serper" --serper_api_key `cat serper_api_key.txt` 
    python scripts/run_search_o1.py --api_base_url "http://localhost:8001/v1" --model_name "Qwen/QwQ-32B"  --dataset_name 'math500' --split 'test' --eval --search_engine "serper" --serper_api_key `cat serper_api_key.txt` 
    python scripts/run_search_o1.py --api_base_url "http://localhost:8001/v1" --model_name "Qwen/QwQ-32B"  --dataset_name 'livecode' --split 'test_1to4' --eval --search_engine "serper" --serper_api_key `cat serper_api_key.txt` 
fi 


##############################################################################
# Run WebThinker single example 
##############################################################################

if [ $subset == "xxx" ]; then
    python scripts/run_web_thinker.py \
        --single_question "What is OpenAI Deep Research?" \
        --search_engine "serper" \
        --serper_api_key `cat serper_api_key.txt` \
        --api_base_url "http://localhost:8001/v1" \
        --model_name "Qwen/QwQ-32B" \
        --aux_api_base_url "http://localhost:8020/v1" \
        --aux_model_name "Qwen/Qwen2.5-32B-Instruct" \
        --tokenizer_path "/fsx-comem/diwu0162/models/tokenizers/Qwen--QwQ-32B" \
        --aux_tokenizer_path "/fsx-comem/diwu0162/models/tokenizers/Qwen--Qwen2.5-32B-Instruct" \
        --max_tokens 40000
fi 


##############################################################################
# Run WebThinker evaluation
##############################################################################

if [ $subset == "xxx" ]; then
    python scripts/run_web_thinker.py --dataset_name 'gpqa' --split 'diamond' --eval --concurrent_limit 32 --max_search_limit 15  --search_engine "serper" --serper_api_key `cat serper_api_key.txt` --api_base_url "http://localhost:8001/v1" --model_name "Qwen/QwQ-32B" --aux_api_base_url "http://localhost:8020/v1" --aux_model_name "Qwen/Qwen2.5-32B-Instruct" --tokenizer_path "/fsx-comem/diwu0162/models/tokenizers/Qwen--QwQ-32B" --aux_tokenizer_path "/fsx-comem/diwu0162/models/tokenizers/Qwen--Qwen2.5-32B-Instruct" --max_tokens 40000 --subset_num 10

    python scripts/run_web_thinker.py --dataset_name 'gaia' --split 'dev' --eval --concurrent_limit 32 --max_search_limit 15  --search_engine "serper" --serper_api_key `cat serper_api_key.txt` --api_base_url "http://localhost:8001/v1" --model_name "Qwen/QwQ-32B" --aux_api_base_url "http://localhost:8020/v1" --aux_model_name "Qwen/Qwen2.5-32B-Instruct" --tokenizer_path "/fsx-comem/diwu0162/models/tokenizers/Qwen--QwQ-32B" --aux_tokenizer_path "/fsx-comem/diwu0162/models/tokenizers/Qwen--Qwen2.5-32B-Instruct" --max_tokens 40000 --subset_num 10
    
    python scripts/run_web_thinker.py --dataset_name 'aime' --split 'test' --eval --concurrent_limit 32 --max_search_limit 15  --search_engine "serper" --serper_api_key `cat serper_api_key.txt` --api_base_url "http://localhost:8003/v1" --model_name "Qwen/QwQ-32B" --aux_api_base_url "http://localhost:8020/v1" --aux_model_name "Qwen/Qwen2.5-32B-Instruct" --tokenizer_path "/fsx-comem/diwu0162/models/tokenizers/Qwen--QwQ-32B" --aux_tokenizer_path "/fsx-comem/diwu0162/models/tokenizers/Qwen--Qwen2.5-32B-Instruct" --max_tokens 40000 --subset_num 10

    python scripts/run_web_thinker.py --dataset_name 'amc' --split 'test' --eval --concurrent_limit 32 --max_search_limit 15  --search_engine "serper" --serper_api_key `cat serper_api_key.txt` --api_base_url "http://localhost:8003/v1" --model_name "Qwen/QwQ-32B" --aux_api_base_url "http://localhost:8020/v1" --aux_model_name "Qwen/Qwen2.5-32B-Instruct" --tokenizer_path "/fsx-comem/diwu0162/models/tokenizers/Qwen--QwQ-32B" --aux_tokenizer_path "/fsx-comem/diwu0162/models/tokenizers/Qwen--Qwen2.5-32B-Instruct" --max_tokens 40000 --subset_num 10

    python scripts/run_web_thinker.py --dataset_name 'math500' --split 'test' --eval --concurrent_limit 32 --max_search_limit 15  --search_engine "serper" --serper_api_key `cat serper_api_key.txt` --api_base_url "http://localhost:8003/v1" --model_name "Qwen/QwQ-32B" --aux_api_base_url "http://localhost:8020/v1" --aux_model_name "Qwen/Qwen2.5-32B-Instruct" --tokenizer_path "/fsx-comem/diwu0162/models/tokenizers/Qwen--QwQ-32B" --aux_tokenizer_path "/fsx-comem/diwu0162/models/tokenizers/Qwen--Qwen2.5-32B-Instruct" --max_tokens 40000 --subset_num 10

    python scripts/run_web_thinker.py --dataset_name 'livecode' --split 'test_1to4' --eval --concurrent_limit 32 --max_search_limit 15  --search_engine "serper" --serper_api_key `cat serper_api_key.txt` --api_base_url "http://localhost:8004/v1" --model_name "Qwen/QwQ-32B" --aux_api_base_url "http://localhost:8020/v1" --aux_model_name "Qwen/Qwen2.5-32B-Instruct" --tokenizer_path "/fsx-comem/diwu0162/models/tokenizers/Qwen--QwQ-32B" --aux_tokenizer_path "/fsx-comem/diwu0162/models/tokenizers/Qwen--Qwen2.5-32B-Instruct" --max_tokens 40000 --subset_num 10
fi 
