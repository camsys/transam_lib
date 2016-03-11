Rails.application.routes.draw do

  # The library routes are all encapsulated under a library namespace
  # for convienece
  scope '/library' do

    resources :library_categories do

      resources :library_documents, :except => [:index] do
        member do
          get 'download'
        end
      end

    end

  end

  resources :library_documents, :only => [] do
    resources :comments
    resources :documents
  end

end
