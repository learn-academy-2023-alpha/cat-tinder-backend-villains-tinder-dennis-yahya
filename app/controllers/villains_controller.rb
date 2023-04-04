class VillainsController < ApplicationController
    def index
        villains = Villain.all 
        render json: villains
      end

    def create
        villain = Villain.create(villain_params)
        if villain.valid? 
          render json: villain
        else
            render json: villain.errors, status: 422
        end
    end

    def update
        villain = Villain.find(params[:id])
        villain.update(villain_params)
        if villain.valid? 
          render json: villain
        else
            render json: villain.errors, status: 422
        end
    end
    
    def destroy
        villain = Villain.find(params[:id])
        villain.destroy 
        render json: villain
    end

private
    def villain_params
        params.require(:villain).permit(:name, :age, :enjoy, :img)
    end
end
