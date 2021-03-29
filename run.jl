using Pkg
Pkg.activate(pwd())
using MarketModel
using Clp

# data_dir = pwd()*"/input/de/"
data_dir = pwd()*"/input/nrel118/"
result_dir = pwd()*"/results/"
optimizer = Clp

# Running the model
# 1) The way MarketModel is executed from pomato, meaning the model is run based on an input data
#    folder, and results are exported to the result_dir folder. Optional argument redispatch
#    includes redispatching of the market result.
MarketModel.run_market_model(data_dir, result_dir, optimizer, redispatch=true)

# 2) Like the model is executed from within the julia model. This way data and options are
#    available ( and editable) within the julia session.
options, data = MarketModel.read_model_data(data_dir);
data.folders["result_dir"] = result_dir
result = MarketModel.run_market_model_redispatch(data, options, Clp, save=false);
