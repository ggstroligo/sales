module SalesHelper
  def success_msg(amount_created)
    {
      title: 'Sucesso!',
      description: "Venda com #{amount_created} pedidos cadastrada!"
    }
  end

  def error_msg(hash_error)
    {
      title: "Linha 1, Coluna #{hash_error[:index]}",
      description: <<-TEXT
                  Esperava: #{hash_error[:expected]}.
                  Recebeu: #{hash_error[:value]}
      TEXT
    }
  end
end
