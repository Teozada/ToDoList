//
//  ViewController.swift
//  listadetarefas
//
//  Created by COTEMIG on 19/08/20.
//  Copyright © 2020 Cotemig. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var array: [String] = []
    let chave: String = "teozada"
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.dataSource = self
        if let lista = UserDefaults.standard.value(forKey: chave) as? [String]{
            array.append(contentsOf: lista)
        }
    }


    @IBAction func adicionar(_ sender: Any) {
        let alert = UIAlertController(title: "Adicionar", message: "Adicione uma mensagem na tabela! ", preferredStyle: .alert)
        let action = UIAlertAction(title: "Salvar", style: .default){_ in
            if let textfield = alert.textFields?.first,
                let textname = textfield.text{
                self.array.append(textname)
                self.tableview.reloadData()
                UserDefaults.standard.set(self.array, forKey: self.chave)
            }
         }
        alert.addAction(action)
        alert.addTextField()
        present(alert,animated:true)
    }
}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            array.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            UserDefaults.standard.set(self.array, forKey: self.chave)
            
        }
    }
}

